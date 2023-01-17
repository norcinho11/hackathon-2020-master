export default class GuidePoint {
  uid: string;
  name: string;
  description: string;
  url: string;
  freeAccess: boolean;
  eventName: string;
  type: GuidePointType;
  lastBeacon: boolean;

  constructor(
    eventName: string,
    uid: string,
    name: string,
    description: string,
    url: string,
    freeAccess: boolean,
    type: GuidePointType,
    lastBeacon: boolean
  ) {
    this.eventName = eventName;
    this.uid = uid;
    this.name = name;
    this.description = description;
    this.url = url;
    this.freeAccess = freeAccess;
    this.type = type;
    this.lastBeacon = lastBeacon;
  }
}

export enum GuidePointType {
  Navigation = 0,
  Information = 1,
}
