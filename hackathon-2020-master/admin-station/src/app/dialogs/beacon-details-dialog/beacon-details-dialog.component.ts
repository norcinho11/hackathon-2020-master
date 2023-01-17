import {Component, Inject, OnInit} from '@angular/core';
import {MAT_DIALOG_DATA, MatDialogRef} from '@angular/material/dialog';
import GuidePoint from "../../models/guidepoint";

@Component({
  selector: 'app-beacon-details-dialog',
  templateUrl: './beacon-details-dialog.component.html',
  styleUrls: ['./beacon-details-dialog.component.scss']
})
export class BeaconDetailsDialogComponent implements OnInit {

  constructor(
    public dialogRef: MatDialogRef<BeaconDetailsDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: GuidePoint,
  ) {}

  ngOnInit(): void {
  }

  cancel() {
    this.dialogRef.close();
  }

}
