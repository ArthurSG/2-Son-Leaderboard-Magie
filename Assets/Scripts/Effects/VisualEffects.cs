﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VisualEffects : MonoBehaviour {
  private static VisualEffects instance;
  private ScreenShake screenShake; 
  private DirectionalScreenShake directionalScreenShake; 

  void Awake() {
    SetSingletonInstance();
    FetchComponents();
  }

  public static void ScreenShake() {
    instance.screenShake.Shake();
  }

  public static void DirectionalScreenShake(Vector2 direction, float intensity, int frames) {
    instance.directionalScreenShake.Shake(direction, intensity, frames);
  }
  

  void SetSingletonInstance() {
    if (instance != null)
      print("multiple instances du singleton \"SpecialEffects\".");
    instance = this;
  }

  void FetchComponents() {
    instance.screenShake = GetComponent<ScreenShake>();
    instance.directionalScreenShake = GetComponent<DirectionalScreenShake>();
  }
}