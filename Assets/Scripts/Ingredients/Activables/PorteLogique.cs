using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PorteLogique : Activable {

  private void Start() {
    base.Start();

  }
  protected override void SetEtat() {
    if (NombreSourcesRequise > 0) {
      GetComponent<Activateur>().Desactiver();
    }
    GetComponent<Activateur>().Activer();
  }
}
