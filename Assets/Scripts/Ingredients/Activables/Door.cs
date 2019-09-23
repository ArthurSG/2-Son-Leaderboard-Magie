using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Door : Activable {
  private Collider2D col;

  // Start is called before the first frame update
  new void Start() {
    base.Start();
    FetchComponents();
  }

  // Update is called once per frame
  void Update() {
    //print(nombreSourcesRequise);
  }

  protected override void SetEtat() {
    if (NombreSourcesRequise > 0) {
      col.isTrigger = false;
      GetComponent<SpriteRenderer>().color = Color.red;
    }
    else {
      col.isTrigger = true;
      GetComponent<SpriteRenderer>().color = Color.green;
    }
  }

  void FetchComponents() {
    col = GetComponent<Collider2D>();
  }
}
