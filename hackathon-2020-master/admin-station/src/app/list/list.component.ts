import { Component, OnInit, ViewChild } from '@angular/core';
import { map } from 'rxjs/operators';
import GuidePoint, { GuidePointType } from '../models/guidepoint';
import { UniversalGuideService } from '../services/universalguide.service';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { ToastrService } from 'ngx-toastr';
import { MatDialog } from '@angular/material/dialog';
import { BeaconDialogComponent } from '../dialogs/beacon-dialog/beacon-dialog.component';
import {BeaconDetailsDialogComponent} from "../dialogs/beacon-details-dialog/beacon-details-dialog.component";

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss'],
})
export class ListComponent implements OnInit {
  displayedColumns = [
    'url',
    'uid',
    'eventName',
    'name',
    'description',
    'freeAccess',
    'isLast',
    'type',
    'actions',
  ];
  beacons: any[];
  dataSource: MatTableDataSource<any>;

  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  constructor(
    private universalGuideService: UniversalGuideService,
    private toast: ToastrService,
    public dialog: MatDialog
  ) {}

  ngOnInit(): void {
    this.retrieveBeaconsToTable();
  }

  retrieveBeaconsToTable(): void {
    this.universalGuideService
      .getAll()
      .snapshotChanges()
      .pipe(
        map((changes) =>
          changes.map((c) => ({
            id: c.payload.doc.id,
            ...c.payload.doc.data(),
          }))
        )
      )
      .subscribe((data) => {
        this.beacons = data;
        this.dataSource = new MatTableDataSource<any>(this.beacons);
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
      });
  }

  applyFilter(filterValue: string) {
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }

  deleteBeacon(row: any) {
    this.universalGuideService
      .delete(row.id)
      .then(() => {
        this.refreshList();
        this.toast.success('The beacon was deleted successfully!');
      })
      .catch((err) => console.log(err));
  }

  editBeacon(row: any) {
    const dialogRef = this.dialog.open(BeaconDialogComponent, {
      data: row,
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.retrieveBeaconsToTable();
      }
    });
  }

  getType(id: number) {
    return GuidePointType[id];
  }

  newBeacon() {
    const dialogRef = this.dialog.open(BeaconDialogComponent, {
      data: undefined,
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result === true) {
        this.retrieveBeaconsToTable();
      }
    });
  }
  private refreshList() {
    this.retrieveBeaconsToTable();
  }

  showDetails(row: any) {
    const dialogRef = this.dialog.open(BeaconDetailsDialogComponent, {
      data: row,
    });
  }
}
