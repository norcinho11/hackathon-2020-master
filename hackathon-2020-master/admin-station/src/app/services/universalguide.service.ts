import { Injectable } from '@angular/core';
import {
  AngularFirestore,
  AngularFirestoreCollection,
} from '@angular/fire/firestore';
import GuidePoint from '../models/guidepoint';

@Injectable({
  providedIn: 'root',
})
export class UniversalGuideService {
  private dbPath = '/guidepoints';

  guidePointsRef: AngularFirestoreCollection<GuidePoint> = null;

  constructor(private db: AngularFirestore) {
    this.guidePointsRef = db.collection(this.dbPath);
  }

  getAll(): AngularFirestoreCollection<GuidePoint> {
    return this.guidePointsRef;
  }

  create(guidePoint: GuidePoint): any {
    return this.guidePointsRef.add({ ...guidePoint });
  }

  update(id: string, data: any): Promise<void> {
    return this.guidePointsRef.doc(id).update(data);
  }

  delete(id: string): Promise<void> {
    return this.guidePointsRef.doc(id).delete();
  }
}
