import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-principale',
  templateUrl: './principale.component.html',
  styleUrls: ['./principale.component.scss']
})
export class PrincipaleComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  goGrafana(){
    this.router.navigateByUrl('grafana');
  }

}
