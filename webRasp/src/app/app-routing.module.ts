import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PrincipaleComponent } from './principale/principale.component';

const routes: Routes = [
  { path: '', component: PrincipaleComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
