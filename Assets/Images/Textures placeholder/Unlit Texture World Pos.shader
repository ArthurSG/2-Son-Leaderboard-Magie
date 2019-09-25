// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Unlit Texture World Pos"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
		_UVScale("UV Scale", Vector) = (1,1,0,0)
		_RotationX("RotationX", Float) = 90
		_RotationY("RotationY", Float) = 90
		_RotationZ("RotationZ", Float) = 90
	}

	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

		Cull Off
		Lighting Off
		ZWrite Off
		Blend One OneMinusSrcAlpha
		
		
		Pass
		{
		CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			

			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float3 ase_normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord  : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
			};
			
			uniform fixed4 _Color;
			uniform float _EnableExternalAlpha;
			uniform sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
			uniform float _RotationZ;
			uniform float _RotationY;
			uniform float _RotationX;
			uniform float2 _UVScale;
			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
			}
			
			float4 MainTexSampler107( float2 UV )
			{
				 float4 output = tex2D(_MainTex, UV);
				return output;
			}
			
			float4 MainTexSampler108( float2 UV )
			{
				 float4 output = tex2D(_MainTex, UV);
				return output;
			}
			
			float4 MainTexSampler109( float2 UV )
			{
				 float4 output = tex2D(_MainTex, UV);
				return output;
			}
			
			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);

				OUT.color = IN.color * _Color;
				float3 ase_worldPos = mul(unity_ObjectToWorld, IN.vertex).xyz;
				OUT.ase_texcoord1.xyz = ase_worldPos;
				float3 ase_worldNormal = UnityObjectToWorldNormal(IN.ase_normal);
				OUT.ase_texcoord2.xyz = ase_worldNormal;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				OUT.ase_texcoord1.w = 0;
				OUT.ase_texcoord2.w = 0;
				
				IN.vertex.xyz +=  float3(0,0,0) ; 
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				
				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}

			fixed4 SampleSpriteTexture (float2 uv)
			{
				fixed4 color = tex2D (_MainTex, uv);

#if ETC1_EXTERNAL_ALPHA
				// get the color from an external texture (usecase: Alpha support for ETC1 on android)
				fixed4 alpha = tex2D (_AlphaTex, uv);
				color.a = lerp (color.a, alpha.r, _EnableExternalAlpha);
#endif //ETC1_EXTERNAL_ALPHA

				return color;
			}
			
			fixed4 frag(v2f IN  ) : SV_Target
			{
				fixed4 spriteCol = IN.color;
				
				float3 _Vector2 = float3(0,0,1);
				float temp_output_71_0 = radians( _RotationZ );
				float3 _Vector1 = float3(0,1,0);
				float temp_output_67_0 = radians( _RotationY );
				float3 _Vector0 = float3(1,0,0);
				float temp_output_61_0 = radians( _RotationX );
				float3 ase_worldPos = IN.ase_texcoord1.xyz;
				float3 rotatedValue54 = RotateAroundAxis( float3( 0,0,0 ), ase_worldPos, _Vector0, temp_output_61_0 );
				float3 rotatedValue66 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue54, _Vector1, temp_output_67_0 );
				float3 rotatedValue72 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue66, _Vector2, temp_output_71_0 );
				float3 break51 = rotatedValue72;
				float3 appendResult52 = (float3(break51.x , break51.y , break51.z));
				float3 break30 = ( appendResult52 / float3( ( -1.0 * abs( _UVScale ) ) ,  0.0 ) );
				float2 appendResult35 = (float2(break30.x , break30.z));
				float2 UV107 = appendResult35;
				float4 localMainTexSampler107 = MainTexSampler107( UV107 );
				float2 appendResult31 = (float2(break30.y , break30.z));
				float2 UV108 = appendResult31;
				float4 localMainTexSampler108 = MainTexSampler108( UV108 );
				float3 ase_worldNormal = IN.ase_texcoord2.xyz;
				float3 rotatedValue75 = RotateAroundAxis( float3( 0,0,0 ), ase_worldNormal, _Vector0, temp_output_61_0 );
				float3 rotatedValue76 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue75, _Vector1, temp_output_67_0 );
				float3 rotatedValue77 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue76, _Vector2, temp_output_71_0 );
				float3 break80 = rotatedValue77;
				float4 lerpResult45 = lerp( localMainTexSampler107 , localMainTexSampler108 , abs( break80.x ));
				float2 appendResult38 = (float2(break30.x , break30.y));
				float2 UV109 = appendResult38;
				float4 localMainTexSampler109 = MainTexSampler109( UV109 );
				float4 lerpResult47 = lerp( lerpResult45 , localMainTexSampler109 , abs( break80.z ));
				
				fixed4 shaderCol = lerpResult47;
				//return shaderCol;
				//return shaderCol;
				//fixed4 c = SampleSpriteTexture (IN.texcoord) * spriteCol;
				fixed4 c = spriteCol * shaderCol;
				c.rgb *= spriteCol.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17000
1920;0;1920;1019;2207.602;2967.441;2.476443;True;False
Node;AmplifyShaderEditor.CommentaryNode;82;-3964.585,-2926.838;Float;False;1851.896;1019.743;World plane rotator;17;62;65;68;61;53;54;70;69;67;73;71;66;72;74;75;76;77;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-3713.212,-2261.57;Float;False;Property;_RotationX;RotationX;1;0;Create;True;0;0;False;0;90;180;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;61;-3537.661,-2254.537;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;53;-3664.407,-2132.095;Float;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;65;-3563.753,-2414.09;Float;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;68;-3285.856,-2094.887;Float;False;Property;_RotationY;RotationY;2;0;Create;True;0;0;False;0;90;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;67;-3062.787,-2089.493;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;69;-3094.875,-2456.874;Float;False;Constant;_Vector1;Vector 1;3;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RotateAboutAxisNode;54;-3336.737,-2302.91;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-2848.274,-2117.862;Float;False;Property;_RotationZ;RotationZ;3;0;Create;True;0;0;False;0;90;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;73;-2657.293,-2479.849;Float;False;Constant;_Vector2;Vector 2;3;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;23;-1971.424,-2282.29;Float;False;835.1289;489.2509;Pos;5;17;20;21;22;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RadiansOpNode;71;-2625.205,-2112.468;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;74;-3914.585,-2876.838;Float;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RotateAboutAxisNode;66;-2881.271,-2305.791;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;17;-1921.425,-1954.039;Float;False;Property;_UVScale;UV Scale;0;0;Create;True;0;0;False;0;1,1;5,6;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RotateAboutAxisNode;72;-2443.689,-2328.766;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;75;-3387.118,-2734.003;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;51;-1900.425,-2418.539;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;20;-1720.314,-2014.648;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;76;-2917.877,-2746.143;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.AbsOpNode;21;-1673.481,-1905.826;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;77;-2452.846,-2689.794;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1516.446,-2002.25;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;52;-1635.055,-2423.986;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;19;-1336.376,-2149.516;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;110;-2017.236,-1822.013;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RelayNode;78;-1239.969,-1114.69;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;32;-558.2656,-2291.724;Float;False;519.4476;280;c1;2;31;108;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;30;-1096.171,-2144.276;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;36;-557.2524,-1939.138;Float;False;548.7903;280;c2;2;35;107;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-540.5756,-2236.452;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;39;-566.2245,-1595.729;Float;False;551.9337;280;c3;2;38;109;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;80;-923.8586,-1024.097;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;42;-396.4587,-1214.097;Float;False;225.1915;274.6836;alpha21;1;41;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;35;-538.0771,-1886.772;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.AbsOpNode;41;-346.4587,-1164.097;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;46;257.6778,-1821.058;Float;False;274.551;293.1096;c21;1;45;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-534.174,-1544.848;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;108;-251.4146,-2155.875;Float;False; float4 output = tex2D(_MainTex, UV)@$return output@;4;False;1;True;UV;FLOAT2;0,0;In;;Float;False;MainTex Sampler;True;False;0;1;0;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;107;-257.8635,-1808.463;Float;False; float4 output = tex2D(_MainTex, UV)@$return output@;4;False;1;True;UV;FLOAT2;0,0;In;;Float;False;MainTex Sampler;True;False;0;1;0;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;43;-387.756,-887.664;Float;False;218.9586;302.1078;alpha23;1;44;;1,1,1,1;0;0
Node;AmplifyShaderEditor.AbsOpNode;44;-353.468,-822.9517;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;45;288.1532,-1765.05;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;48;629.8294,-1802.661;Float;False;304.5889;281.0945;c23;1;47;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CustomExpressionNode;109;-246.6392,-1471.733;Float;False; float4 output = tex2D(_MainTex, UV)@$return output@;4;False;1;True;UV;FLOAT2;0,0;In;;Float;False;MainTex Sampler;True;False;0;1;0;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;47;679.8294,-1752.661;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;111;1245.636,-1759.318;Float;False;True;2;Float;ASEMaterialInspector;0;10;Unlit Texture World Pos;f36a4a3a878dbee4d9ec370f7fef72e0;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;2;True;3;1;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;True;2;False;-1;False;False;True;2;False;-1;False;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;61;0;62;0
WireConnection;67;0;68;0
WireConnection;54;0;65;0
WireConnection;54;1;61;0
WireConnection;54;3;53;0
WireConnection;71;0;70;0
WireConnection;66;0;69;0
WireConnection;66;1;67;0
WireConnection;66;3;54;0
WireConnection;72;0;73;0
WireConnection;72;1;71;0
WireConnection;72;3;66;0
WireConnection;75;0;65;0
WireConnection;75;1;61;0
WireConnection;75;3;74;0
WireConnection;51;0;72;0
WireConnection;76;0;69;0
WireConnection;76;1;67;0
WireConnection;76;3;75;0
WireConnection;21;0;17;0
WireConnection;77;0;73;0
WireConnection;77;1;71;0
WireConnection;77;3;76;0
WireConnection;22;0;20;0
WireConnection;22;1;21;0
WireConnection;52;0;51;0
WireConnection;52;1;51;1
WireConnection;52;2;51;2
WireConnection;19;0;52;0
WireConnection;19;1;22;0
WireConnection;110;0;77;0
WireConnection;78;0;110;0
WireConnection;30;0;19;0
WireConnection;31;0;30;1
WireConnection;31;1;30;2
WireConnection;80;0;78;0
WireConnection;35;0;30;0
WireConnection;35;1;30;2
WireConnection;41;0;80;0
WireConnection;38;0;30;0
WireConnection;38;1;30;1
WireConnection;108;0;31;0
WireConnection;107;0;35;0
WireConnection;44;0;80;2
WireConnection;45;0;107;0
WireConnection;45;1;108;0
WireConnection;45;2;41;0
WireConnection;109;0;38;0
WireConnection;47;0;45;0
WireConnection;47;1;109;0
WireConnection;47;2;44;0
WireConnection;111;0;47;0
ASEEND*/
//CHKSM=7EDE05F23963E441A4C0CB486E268025C26D0CEF