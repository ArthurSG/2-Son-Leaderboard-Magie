using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerZoneApneaPause : MonoBehaviour
{
	private Teleportation teleportation;

    void Start()
    {
        teleportation = GameManager.instance.avatar.gameObject.GetComponent<Teleportation>();
    }


    void Update()
    {
        
    }

    void OnTriggerEnter2D (Collider2D col){
    	teleportation.ApneaPause();
    }

    void OnTriggerExit2D (Collider2D col){
    	teleportation.ApneaPlay();
    }
}
