using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Teleportation : MonoBehaviour {

  public float apneaDuration = 3f;
  public int numberOfConsecutiveTeleportation;
  public float teleportationMaximumDistance;

  private Avatar avatarClass;

  private List<Vector3> positionsSaved;
  private List<Timer> apneaTimers;


  void Start() {
    positionsSaved = new List<Vector3>();
    apneaTimers = new List<Timer>();

    avatarClass = GetComponent<Avatar>();
  }


  public void Teleport(float aimX, float aimY) {

    if (positionsSaved.Count < numberOfConsecutiveTeleportation) {
      positionsSaved.Add(transform.position);

      transform.position = FindTeleportPosition(aimX, aimY);

      SetNewApneaTimer();
    }
    else { //Can Cancel the Apnea Time and Rappel before the apneaTimer End();
      ApneaReset ();
    }
  }

  private void SetNewApneaTimer (){
  	foreach (Timer t in apneaTimers)
      t.Pause();
    apneaTimers.Add(new Timer(apneaDuration, avatarClass.AnimationRappel));
    apneaTimers[apneaTimers.Count -1].Play();
  }

  private Vector3 FindTeleportPosition(float aimX, float aimY) {
    Vector3 position;
    Vector2 direction = new Vector2(aimX, aimY).normalized;
    position = new Vector3(
        transform.position.x + direction.x * teleportationMaximumDistance,
        transform.position.y + direction.y * teleportationMaximumDistance,
        transform.position.z);

    return position;
  }

  public void Rappel(){
    transform.position = positionsSaved[positionsSaved.Count -1];
    positionsSaved.RemoveAt(positionsSaved.Count - 1);
    apneaTimers.RemoveAt(apneaTimers.Count - 1);
    if (apneaTimers.Count > 0)
      apneaTimers[apneaTimers.Count - 1].Play();
  }

  public void ApneaPause (){
    apneaTimers[apneaTimers.Count -1].Pause();
  }

  public void ApneaPlay (){
    apneaTimers[apneaTimers.Count -1].Play();
  }

  public void ApneaReset (){
    avatarClass.AnimationRappel();
    apneaTimers[apneaTimers.Count -1].Reset();
  }

  public void ApneaResetPlay (){
    apneaTimers[apneaTimers.Count -1].ResetPlay();
  }
}
