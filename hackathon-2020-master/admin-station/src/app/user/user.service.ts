import {Injectable} from '@angular/core';
import {FormBuilder, Validators, FormGroup} from '@angular/forms';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {BehaviorSubject, Observable, throwError} from 'rxjs';
import {catchError, tap} from 'rxjs/operators';
import {Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  constructor(private fb: FormBuilder, private router: Router, public toast: ToastrService) {
  }

  isLoggedIn = false;

  formModel = this.fb.group({
    UserName: ['', Validators.required],
    Email: ['', [Validators.email, Validators.required]],
    FullName: ['', Validators.required],
    Passwords: this.fb.group({
      Password: ['', [Validators.required, Validators.minLength(4)]],
      ConfirmPassword: ['', Validators.required]
    }, {validator: this.comparePasswords})

  });

  updateLoggedInState(status: boolean) {
    this.isLoggedIn = status;
    if (!status) {
      this.router.navigate(['/login']);
    }
  }

  comparePasswords(fb: FormGroup) {
    const confirmPswrdCtrl = fb.get('ConfirmPassword');
    if (confirmPswrdCtrl.errors == null || 'passwordMismatch' in confirmPswrdCtrl.errors) {
      if (fb.get('Password').value !== confirmPswrdCtrl.value) {
        confirmPswrdCtrl.setErrors({passwordMismatch: true});
      } else {
        confirmPswrdCtrl.setErrors(null);
      }
    }
  }

  register() {
    const body = {
      UserName: this.formModel.value.UserName,
      Email: this.formModel.value.Email,
      FullName: this.formModel.value.FullName,
      Password: this.formModel.value.Passwords.Password
    };
    this.isLoggedIn = true;
    localStorage.setItem('token', 'token');
    this.toast.success('Welcome!', 'Successfully registered!');
    this.router.navigateByUrl('/home');
  }

  login(form: any): boolean{
    if (form.value.UserName === 'hackathon' && form.value.Password === 'guide') {
      this.isLoggedIn = true;
      localStorage.setItem('token', 'token');
      this.router.navigateByUrl('/home');
      this.toast.success('Welcome!', 'Successfully logged in!');

      return true;
    }
    return false;
  }

}
