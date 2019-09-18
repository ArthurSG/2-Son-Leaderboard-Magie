using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour {
  public static GameManager instance;

  public Avatar avatar;
  public Camera camera;
  public GameObject spirit;

  private void Awake() {
    if (instance != null)
      print("/!\\ Two instances of GameManager.");
    instance = this;
  }

}
