import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import {animate, style, transition, trigger} from '@angular/animations';
import {UserService} from '../user.service';
import {ToastrService} from 'ngx-toastr';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent implements OnInit {
  formModel = {
    UserName: '',
    Password: ''
  };
  loginInvalid = false;
  hide = true;
  constructor(public userService: UserService, private router: Router, public toast: ToastrService) { }

  ngOnInit() {
    if (localStorage.getItem('token') != null) {
      this.userService.isLoggedIn = true;
      this.router.navigateByUrl('/home');
    }
  }

  onSubmit(form: NgForm) {
    if(this.userService.login(form) === false){
      this.toast.error('Please try again', 'Invalid credentials!');
    }
  }

  redirectToRegistration() {
    this.router.navigateByUrl('/register');
  }

}
