import { GuidePointType } from './../../models/guidepoint';
import { Component, Inject, OnInit } from '@angular/core';
import { ImagePickerConf } from 'ngp-image-picker';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ToastrService } from 'ngx-toastr';
import GuidePoint from '../../models/guidepoint';
import { UniversalGuideService } from '../../services/universalguide.service';
import { ImageUploadService } from '../../services/imageupload.service';

interface Types {
  value: number;
  viewValue: string;
}

@Component({
  selector: 'app-beacon-dialog',
  templateUrl: './beacon-dialog.component.html',
  styleUrls: ['./beacon-dialog.component.scss'],
})
export class BeaconDialogComponent implements OnInit {
  types: Types[] = [
    {
      value: 0,
      viewValue: GuidePointType[0],
    },
    {
      value: 1,
      viewValue: GuidePointType[1],
    },
  ];
  imagePickerConf: ImagePickerConf = {
    borderRadius: '4px',
    language: 'en',
    width: '320px',
    height: '240px',
  };
  beacon;
  image;
  newBeacon = false;

  constructor(
    public dialogRef: MatDialogRef<BeaconDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    public toast: ToastrService,
    private universalGuideService: UniversalGuideService,
    private imageUploadService: ImageUploadService
  ) {}

  onImageChange($event: any) {
    this.toast.success('Image picked!');
    this.image = $event;
  }

  ngOnInit(): void {
    if (this.data) {
      this.newBeacon = false;
      this.beacon = Object.assign({}, this.data);
    } else {
      this.newBeacon = true;
      this.beacon = new GuidePoint(
        'test',
        '',
        '',
        '',
        '',
        false,
        GuidePointType.Navigation,
        false
      );
    }
  }

  cancel() {
    this.dialogRef.close();
  }

  onSubmit() {
    if (this.newBeacon) {
      this.createBeacon();
    } else {
      this.editBeacon();
    }
  }

  private createBeacon() {
    let imageName = '';
    imageName = Math.random().toString(36).substring(2);
    imageName = `${this.beacon.uid}_${imageName}`;
    if (this.image) {
      const file = this.imageUploadService.createFile(this.image, imageName);
      this.imageUploadService.upload(file).then((url) => {
        this.beacon.url = url;
        this.universalGuideService.create(this.beacon).then(() => {
          console.log('Created new Item successfully!');
          this.toast.success('Created new Item successfully!');
        });
      });
    }
    this.dialogRef.close(true);
  }

  private editBeacon() {
    console.log(this.beacon);
    let imageName = '';
    imageName = Math.random().toString(36).substring(2);
    imageName = `${this.beacon.uid}_${imageName}`;
    if (this.image) {
      const file = this.imageUploadService.createFile(this.image, imageName);
      this.imageUploadService.upload(file).then((url) => {
        this.universalGuideService
          .update(this.beacon.id, {
            eventName: this.beacon.eventName,
            uid: this.beacon.uid,
            name: this.beacon.name,
            description: this.beacon.description,
            url,
            freeAccess: this.beacon.freeAccess && this.beacon.type === 0,
            type: this.beacon.type,
            lastBeacon: this.beacon.lastBeacon,
          })
          .then(() => {
            console.log('Updated item successfully!');
            this.toast.success('Updated item successfully!');
          });
      });
    } else {
      console.log(this.beacon.type);
      this.universalGuideService
        .update(this.beacon.id, {
          eventName: this.beacon.eventName,
          uid: this.beacon.uid,
          name: this.beacon.name,
          description: this.beacon.description,
          freeAccess: this.beacon.freeAccess && this.beacon.type == 0,
          type: this.beacon.type,
          lastBeacon: this.beacon.lastBeacon,
        })
        .then(() => {
          console.log('Updated item successfully!');
          this.toast.success('Updated item successfully!');
        });
    }

    this.dialogRef.close(true);
  }
}
