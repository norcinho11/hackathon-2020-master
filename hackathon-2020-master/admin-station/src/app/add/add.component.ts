import { Component, OnInit } from '@angular/core';
import { ImagePickerConf } from 'ngp-image-picker';
import { ToastrService } from 'ngx-toastr';

import { UniversalGuideService } from 'src/app/services/universalguide.service';
import { ImageUploadService } from 'src/app/services/imageupload.service';
import GuidePoint from 'src/app/models/guidepoint';

@Component({
  selector: 'app-add',
  templateUrl: './add.component.html',
  styleUrls: ['./add.component.scss'],
})
export class AddComponent implements OnInit {
  imagePickerConf: ImagePickerConf = {
    borderRadius: '4px',
    language: 'en',
    width: '320px',
    height: '240px',
  };
  id;
  description;
  image;

  constructor(
    public toast: ToastrService,
    private universalGuideService: UniversalGuideService,
    private imageUploadService: ImageUploadService
  ) {}

  ngOnInit(): void {}

  onImageChange($event: any) {
    this.toast.success('Image picked!');
    console.log($event);
    this.image = $event;
  }

  submitToFirebase() {
    console.log(this.id, this.imagePickerConf);

    let imageName = '';
    imageName = Math.random().toString(36).substring(2);
    imageName = `${this.id}_${imageName}`;
    if (this.image) {
      const file = this.imageUploadService.createFile(this.image, imageName);
      this.imageUploadService.upload(file).then((url) => {
        this.universalGuideService
          .create(
            new GuidePoint(
              null,
              null,
              this.id,
              this.description,
              url,
              null,
              null,
              null
            )
          )
          .then(() => {
            console.log('Created new Item successfully!');
            this.toast.success('Created new Item successfully!');
          });
      });
    }
  }
}
