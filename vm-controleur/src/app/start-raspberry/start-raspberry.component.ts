import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-start-raspberry',
  templateUrl: './start-raspberry.component.html',
  styleUrls: ['./start-raspberry.component.scss']
})
export class StartRaspberryComponent implements OnInit {

  constructor(private router: Router, private Http: HttpClient) { }

  ngOnInit(): void {
  }

  retour(){
    this.router.navigateByUrl('demoAccueil')
  }

  verif(){
    console.log('connexion');
    return this.Http.get<any>(`http://localhost:8080`);
  }
}
