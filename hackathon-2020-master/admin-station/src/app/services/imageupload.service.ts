import {
  AngularFireStorage,
} from '@angular/fire/storage';
import {Injectable} from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class ImageUploadService {
  constructor(private fireStorage: AngularFireStorage) {
  }

  mediaFolderPath = 'images';

  async upload(fileToUpload: File): Promise<any> {
    const {name} = fileToUpload;

    const filePath = `${this.mediaFolderPath}/${new Date().getTime()}_${name}`;
    let response = await this.fireStorage.upload(filePath, fileToUpload);

    if (response) {
      return this.getDownloadUrl(filePath);
    }
  }

  convertDataUrlToBlob(dataUrl): Blob {
    const arr = dataUrl.split(',');
    const mime = arr[0].match(/:(.*?);/)[1];
    const bstr = atob(arr[1]);
    let n = bstr.length;
    const u8arr = new Uint8Array(n);

    while (n--) {
      u8arr[n] = bstr.charCodeAt(n);
    }

    return new Blob([u8arr], {type: mime});
  }

  createFile(dataurl, filename): File {
    const imageFile = new File([this.convertDataUrlToBlob(dataurl)], filename, {
      type: `image/png`,
    });
    return imageFile;
  }

  getDownloadUrl(filePath: string): Promise<any> {
    const storage = this.fireStorage.storage;

    return storage.ref(filePath).getDownloadURL();
  }
}
