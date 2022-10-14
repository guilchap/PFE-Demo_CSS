import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AccueilComponent } from './accueil/accueil.component';
import { DemoAccueilComponent } from './demo-accueil/demo-accueil.component';
import { EtudiantsComponent } from './etudiants/etudiants.component';
import { ProduitsComponent } from './produits/produits.component';
import { StartRaspberryComponent } from './start-raspberry/start-raspberry.component';

const routes: Routes = [
  { path: 'demoAccueil', component: DemoAccueilComponent},
  { path: 'etudiants', component: EtudiantsComponent},
  { path: 'produits', component: ProduitsComponent},
  { path: 'startRasp', component: StartRaspberryComponent},
  { path: '', component: AccueilComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
