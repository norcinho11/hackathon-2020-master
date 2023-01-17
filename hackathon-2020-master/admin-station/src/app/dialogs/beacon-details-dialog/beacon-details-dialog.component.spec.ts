import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BeaconDetailsDialogComponent } from './beacon-details-dialog.component';

describe('BeaconDetailsDialogComponent', () => {
  let component: BeaconDetailsDialogComponent;
  let fixture: ComponentFixture<BeaconDetailsDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BeaconDetailsDialogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BeaconDetailsDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
