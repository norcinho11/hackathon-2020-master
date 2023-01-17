import { Component, OnInit } from '@angular/core';
import {animate, style, transition, trigger} from '@angular/animations';
import {Router} from '@angular/router';
import {UserService} from '../user.service';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.scss'],
  animations: [
    trigger('inOutAnimation', [
      transition(':enter', [
        style({transform: 'translateY(-300%)'}),
        animate('300ms ease-in', style({transform: 'translateY(0%)'}))
      ]),
      transition(':leave', [
        animate('300ms ease-in', style({transform: 'translateY(-300%)'}))
      ])
    ])
  ]
})
export class RegistrationComponent implements OnInit {

  hidePassword = true;
  cardMessageShown: any;
  cardMessage: any;



  constructor(public service: UserService,  private router: Router) { }

  ngOnInit() {
    this.service.formModel.reset();
  }


  onSubmit() {
    if (this.service.formModel.invalid) {
      this.showCard('Please fill all the required fields!');
      return;
    }
    this.service.register();
  }

  redirectToSignIn() {
    this.router.navigate(['login']);
  }
  showCard(message: string) {
    window.scroll({top: 0 , behavior: 'smooth'});
    this.cardMessageShown = true;
    this.cardMessage = message;
  }

  hideCard() {
    this.cardMessageShown = false;
  }
}
