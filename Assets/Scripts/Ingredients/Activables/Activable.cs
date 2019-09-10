using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Activable : MonoBehaviour {
  public int nombreSourcesRequiseMax;
  protected int nombreSourcesRequise;                     // nombreSourcesRequise si <= 0


  protected void Start() {
    nombreSourcesRequise = nombreSourcesRequiseMax;
  }

  public void Activer() {
    nombreSourcesRequise--;
    SetEtat();
  }

  public void Desactiver() {
    nombreSourcesRequise++;
    SetEtat();
  }

  protected abstract void SetEtat();
}
