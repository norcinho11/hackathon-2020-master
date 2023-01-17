import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {LoginComponent} from './user/login/login.component';
import {RegistrationComponent} from './user/registration/registration.component';
import {AuthGuard} from './auth/auth.guard';
import {HomeComponent} from './home/home.component';
import {AddComponent} from './add/add.component';
import {EditComponent} from './edit/edit.component';
import {ListComponent} from './list/list.component';

const routes: Routes =  [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegistrationComponent },
  { path: 'home', component: HomeComponent},
  { path: 'add', component: AddComponent},
  { path: 'edit', component: EditComponent},
  { path: 'list', component: ListComponent}

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
