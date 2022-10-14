import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-demo-accueil',
  templateUrl: './demo-accueil.component.html',
  styleUrls: ['./demo-accueil.component.scss']
})
export class DemoAccueilComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  retour(){
    this.router.navigateByUrl('');
  }

}
