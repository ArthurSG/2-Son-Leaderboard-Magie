using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Key : MonoBehaviour
{
  public MenuPage KeyPage;
  private void OnTriggerEnter2D(Collider2D collision) {
    if(collision.gameObject.tag == "Player"){
      GameManager.instance.avatar.AddKey();
      KeyHUD.ShowKeys();
      Destroy(this.gameObject);
    }
  }
}