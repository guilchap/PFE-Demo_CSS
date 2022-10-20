import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-grafana',
  templateUrl: './grafana.component.html',
  styleUrls: ['./grafana.component.scss']
})
export class GrafanaComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  retour(){
    this.router.navigateByUrl('');
  }

}
