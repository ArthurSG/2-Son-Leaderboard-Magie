using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Key : MonoBehaviour
{
  private void OnTriggerEnter2D(Collider2D collision) {
    print("oui");
    if(collision.gameObject.tag == "Player"){
      GameManager.instance.avatar.AddKey();
      Destroy(this.gameObject);
    }
  }
}