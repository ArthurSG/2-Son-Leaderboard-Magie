using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TextureScroll : MonoBehaviour{
  
	public float ScrollSpeedX = 0.5f;

	public Renderer renderer;

  void Start(){
  //  FetchComponents();
        
  }

  void Update(){
  	//ScrollSpeedX += 0.1f;
  	Scroll();
  }

  void Scroll (){
  	renderer.material.mainTextureOffset = new Vector2 (ScrollSpeedX * Time.deltaTime,0);
  }

  void FetchComponents(){
  	//renderer = GetComponent<Renderer>();
  }
}
