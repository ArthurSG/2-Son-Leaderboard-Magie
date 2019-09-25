﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class Teleportation : MonoBehaviour {

  public GameObject teleportationTarget;
  public float apneaDuration = 3f;
  public int numberOfConsecutiveTeleportation;
  public float teleportationMaximumDistance;
  public float shakeIntensite = 1f;
  public int shakeFrames = 5;

  private Avatar avatarClass;
  private Rigidbody2D rb2D;
  private List<Vector3> positionsSaved;
  private List<Timer> apneaTimers;

  void Start() {
    FetchComponents ();
  }

  public void MoveTeleportationTarget(Vector2 direction){
    teleportationTarget.transform.position = FindTeleportPosition(direction); 
  }

  public void Teleport(Vector2 direction) {
    if (positionsSaved.Count < numberOfConsecutiveTeleportation) {
      VisualEffects.DirectionalScreenShake(direction,shakeIntensite,shakeFrames);
      VisualEffects.VignetteAfterTeleportation();
      var position = transform.position;

      positionsSaved.Add(position);

      SetNewApneaTimer();


      GameManager.instance.avatar.spirit.SetSpiritActive(true);

      transform.Translate(teleportationTarget.transform.localPosition);
      GameManager.instance.avatar.isInTP = true;

    }
    else { //Can Cancel the Apnea Time and Rappel before the apneaTimer End();
      ApneaReset ();
    }
  }

  private void SetNewApneaTimer (){
  	foreach (Timer t in apneaTimers){
      t.Pause();
    }
    apneaTimers.Add(new Timer(apneaDuration, avatarClass.AnimationRappel));
    apneaTimers[apneaTimers.Count -1].Play();
    
  }

  private Vector3 FindTeleportPosition(Vector2 aimDirection) {
    Vector2 direction = aimDirection.normalized;

    var posGo = transform.position;

        
    Vector3 posTp = new Vector3(
    posGo.x + direction.x * teleportationMaximumDistance,
    posGo.y + direction.y * teleportationMaximumDistance,
      posGo.z);

    float radius = GameManager.instance.avatar.GetComponent<CircleCollider2D>().radius;

    for (int i = 10; i >= 0; i--)
    {
        Vector3 posToCheck = posGo + ((posTp - posGo) * (i/10f)); // On vérifie la pos
        
        Collider2D[] colls = Physics2D.OverlapCircleAll(posToCheck, radius, LayerMask.GetMask("Floor", "Wall"));

        if (colls.Length > 0 && !Array.Exists(colls, x => !x.CompareTag("Walkable")))
        {
          if (GameManager.instance.useNewSpaceModel)
            posToCheck = new Vector3(posToCheck.x, posToCheck.z, posToCheck.y);
          return posToCheck; // On a trouvé aucun non walkable, la position est valide
        }

    }

    return posGo; // Pas de position trouvée dans la range, on renvoie la pos actuelle de l'avatar
  }

  public void Rappel(){
    transform.position = positionsSaved[positionsSaved.Count -1];
    positionsSaved.RemoveAt(positionsSaved.Count - 1);
    apneaTimers.RemoveAt(apneaTimers.Count - 1);

    if (apneaTimers.Count > 0)
    {
        apneaTimers[apneaTimers.Count - 1].Play();
        GameManager.instance.avatar.spirit.transform.position = positionsSaved[positionsSaved.Count - 1];
    }
    else
    {
        GameManager.instance.avatar.spirit.SetSpiritActive(false);
    }
  }

  public void ApneaPause (){
    if (apneaTimers.Count > 0){
      apneaTimers[apneaTimers.Count -1].Pause();
    }
  }

  public void ApneaPlay (){
    if (apneaTimers.Count > 0){
      apneaTimers[apneaTimers.Count -1].Play();
    }
  }

  public void ApneaReset (){
    avatarClass.AnimationRappel();
    if (apneaTimers.Count > 0){
      apneaTimers[apneaTimers.Count -1].Reset();
    }
  }

  public void ApneaResetPlay (){
    if (apneaTimers.Count > 0){
      apneaTimers[apneaTimers.Count -1].ResetPlay();
    }
  }

  public void ApneaCancel (){
   
    if (apneaTimers.Count > 0){
      apneaTimers[apneaTimers.Count -1].Pause();
      apneaTimers.Clear();
    }
    positionsSaved.Clear();
    GameManager.instance.avatar.spirit.SetSpiritActive(false);
  }

  void FetchComponents (){
  	positionsSaved = new List<Vector3>();
    apneaTimers = new List<Timer>();

    avatarClass = GetComponent<Avatar>();
    rb2D = GetComponent<Rigidbody2D>();
  }

  
}
