import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { GrafanaComponent } from './grafana/grafana.component';
import { PrincipaleComponent } from './principale/principale.component';

const routes: Routes = [
  { path: '', component: PrincipaleComponent},
  { path: 'grafana', component: GrafanaComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
