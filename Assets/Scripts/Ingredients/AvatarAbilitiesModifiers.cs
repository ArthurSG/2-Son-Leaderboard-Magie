using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarAbilitiesModifiers : MonoBehaviour{

	private GameObject Avatar;

	public int priorityLevel;

	public List<bool> abilitiesModifiers = new List<bool>();

	public bool canMove = true;
	public bool canTeleport = true;
	public bool canRappel = true;
	public bool canLift = true;
	public bool canRelease = true; // Lorsque l'on porte un ingredient, pouvoir le reposer ou non. 



  void Start(){
    Avatar = GameManager.Avatar;

    abilitiesModifiers.Add(canMove);
    abilitiesModifiers.Add(canRelease);
    abilitiesModifiers.Add(canLift);
    abilitiesModifiers.Add(canRelease);
    abilitiesModifiers.Add(canTeleport);

  }


  void Update(){
        
  }
}
