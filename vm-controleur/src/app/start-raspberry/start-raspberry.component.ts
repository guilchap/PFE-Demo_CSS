import { HttpClient } from '@angular/common/http';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, Subject, takeUntil } from 'rxjs';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-start-raspberry',
  templateUrl: './start-raspberry.component.html',
  styleUrls: ['./start-raspberry.component.scss']
})
export class StartRaspberryComponent implements OnInit, OnDestroy {

  constructor(private router: Router, private Http: HttpClient) { }

  private destroy$!: Subject<boolean>;

  ngOnDestroy(): void {
    this.destroy$.next(true);
  }

  ngOnInit(): void {
    this.destroy$ = new Subject<boolean>();
  }

  retour(){
    this.router.navigateByUrl('demoAccueil')
  }

  verif(){
    console.log('connexion');
    return this.Http.get<any>(`http://localhost:8080`).pipe(takeUntil(this.destroy$)).subscribe();
  }
}
