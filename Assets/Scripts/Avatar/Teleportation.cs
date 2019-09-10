using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Teleportation : MonoBehaviour {

  public float TeleportDuration = 3f;
  public int nombreDeTeleportation;
  public float distanceDeTeleportation;

  private List<Vector3> positionsSaved;
  private List<Timer> timers;

  // Start is called before the first frame update
  void Start() {
    positionsSaved = new List<Vector3>();
    timers = new List<Timer>();
  }

  // Update is called once per frame
  void Update() {

  }

  public void Teleport(float aimX, float aimY) {

    if (positionsSaved.Count - 1 < nombreDeTeleportation) {
      print("Téléportation");
      positionsSaved.Add(transform.position);

      transform.position = FindTeleportPosition(aimX, aimY);

      foreach (Timer t in timers)
        t.Pause();
      timers.Add(new Timer(TeleportDuration, GetComponent<Avatar>().AnimationRappel));
      timers[timers.Count -1].Play();
    }
  }

  private Vector3 FindTeleportPosition(float aimX, float aimY) {
    Vector3 position;
    Vector2 direction = new Vector2(aimX, aimY).normalized;
    position = new Vector3(
        transform.position.x + direction.x * distanceDeTeleportation,
        transform.position.y + direction.y * distanceDeTeleportation,
        transform.position.z);

    return position;
  }

  public void Rappel(){
    transform.position = positionsSaved[positionsSaved.Count -1];
    positionsSaved.RemoveAt(positionsSaved.Count - 1);
    timers.RemoveAt(timers.Count - 1);
    if (timers.Count > 0)
      timers[timers.Count - 1].Play();
  }
}
