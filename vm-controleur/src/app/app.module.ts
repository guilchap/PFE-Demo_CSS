import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HeaderComponent } from './header/header.component';
import { FooterComponent } from './footer/footer.component';
import { AccueilComponent } from './accueil/accueil.component';
import { DemoAccueilComponent } from './demo-accueil/demo-accueil.component';
import { EtudiantsComponent } from './etudiants/etudiants.component';
import { ProduitsComponent } from './produits/produits.component';
import { StartRaspberryComponent } from './start-raspberry/start-raspberry.component';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    FooterComponent,
    AccueilComponent,
    DemoAccueilComponent,
    EtudiantsComponent,
    ProduitsComponent,
    StartRaspberryComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
