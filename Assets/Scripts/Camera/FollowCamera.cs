using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowCamera : MonoBehaviour {

  // public GameObject target;
  // public float maxDistance;
  // public float timeToTarget;


  // void Update() {
  //   if (target != null) {
  //     FollowTarget();
  //   }
  // }

  // void FollowTarget() {
  //   Vector3 movementToTarget = FullMovementToTarget();
  //   float distanceToTarget = 
  //   float distanceToTravel = Mathf.SmoothStep(0, Mathf.Min(movementToTarget.magnitude, maxDistance));
    
  // }

  // Vector3 FullMovementToTarget() { return target.position - transform.position; }

  public Transform target;
  public float damping = 1;
  public float lookAheadFactor = 3;
  public float lookAheadReturnSpeed = 0.5f;
  public float lookAheadMoveThreshold = 0.1f;

  private float m_OffsetZ;
  private Vector3 m_LastTargetPosition;
  private Vector3 m_CurrentVelocity;
  private Vector3 m_LookAheadPos;

  void Start() {
    m_LastTargetPosition = target.position;
    m_OffsetZ = (transform.position - target.position).z;
    transform.parent = null;
  }

  void Update() {
      // only update lookahead pos if accelerating or changed direction
      float xMoveDelta = (target.position - m_LastTargetPosition).x;

      bool updateLookAheadTarget = Mathf.Abs(xMoveDelta) > lookAheadMoveThreshold;

      if (updateLookAheadTarget)
      {
          m_LookAheadPos = lookAheadFactor*Vector3.right*Mathf.Sign(xMoveDelta);
      }
      else
      {
          m_LookAheadPos = Vector3.MoveTowards(m_LookAheadPos, Vector3.zero, Time.deltaTime*lookAheadReturnSpeed);
      }

      Vector3 aheadTargetPos = target.position + m_LookAheadPos + Vector3.forward*m_OffsetZ;
      Vector3 newPos = Vector3.SmoothDamp(transform.position, aheadTargetPos, ref m_CurrentVelocity, damping);

      transform.position = newPos;

      m_LastTargetPosition = target.position;
  }

}
