import { Component } from '@angular/core';
import {Router} from '@angular/router';
import {FocusMonitor} from '@angular/cdk/a11y';
import {UserService} from './user/user.service';
import {ToastrService} from 'ngx-toastr';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'universal-beacon-guide';

  constructor(private router: Router, public service: UserService, private _focusMonitor: FocusMonitor, public toast: ToastrService) {
    if(localStorage.getItem('token') !== null){
      service.isLoggedIn = true;
    }
  }

  onLogout() {
    localStorage.removeItem('token');
    this.service.updateLoggedInState(false);
    this.router.navigate(['login']);
    this.toast.success('Signed out');
  }
}
