import {Component, OnInit} from '@angular/core';
import {UniversalGuideService} from '../services/universalguide.service';
import {map} from 'rxjs/operators';

@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss']
})
export class EditComponent implements OnInit {
  beacons;

  constructor(
    private universalGuideService: UniversalGuideService,
  ) {
  }

  ngOnInit(): void {
    this.retrieveBeacons();
  }

  retrieveBeacons(): void {
    this.universalGuideService.getAll().snapshotChanges().pipe(
      map(changes =>
        changes.map(c =>
          ({id: c.payload.doc.id, ...c.payload.doc.data()})
        )
      )
    ).subscribe(data => {
      console.log(data);
      this.beacons = data;
    });
  }
}
