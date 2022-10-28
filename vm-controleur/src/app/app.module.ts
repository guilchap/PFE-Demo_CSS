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
import { GrafanaComponent} from './grafana/grafana.component';
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    FooterComponent,
    AccueilComponent,
    DemoAccueilComponent,
    EtudiantsComponent,
    ProduitsComponent,
    StartRaspberryComponent,
    GrafanaComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
