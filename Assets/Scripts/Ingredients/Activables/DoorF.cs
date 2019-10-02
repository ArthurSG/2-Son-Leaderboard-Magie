using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DoorF : Activable {
  private Collider2D col;

  // Start is called before the first frame update
  new void Start() {
    base.Start();
    FetchComponents();
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

  private void OnTriggerEnter2D(Collider2D collision) {
    SceneManager.LoadScene("Menu Principale");
  }
}
