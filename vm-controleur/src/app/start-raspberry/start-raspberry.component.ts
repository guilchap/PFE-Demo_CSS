import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-start-raspberry',
  templateUrl: './start-raspberry.component.html',
  styleUrls: ['./start-raspberry.component.scss']
})
export class StartRaspberryComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  retour(){
    this.router.navigateByUrl('demoAccueil')
  }

  verif(){
    
  }
}
