// Upgrade NOTE: upgraded instancing buffer 'UnlitTextureWorldPos' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Unlit Texture World Pos"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_UVScale("UV Scale", Vector) = (1,1,0,0)
		_RotationX("RotationX", Float) = 90
		_RotationY("RotationY", Float) = 90
		_RotationZ("RotationZ", Float) = 90
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.0
		#pragma multi_compile_instancing
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _Texture0;

		UNITY_INSTANCING_BUFFER_START(UnlitTextureWorldPos)
			UNITY_DEFINE_INSTANCED_PROP(float2, _UVScale)
#define _UVScale_arr UnlitTextureWorldPos
			UNITY_DEFINE_INSTANCED_PROP(float, _RotationZ)
#define _RotationZ_arr UnlitTextureWorldPos
			UNITY_DEFINE_INSTANCED_PROP(float, _RotationY)
#define _RotationY_arr UnlitTextureWorldPos
			UNITY_DEFINE_INSTANCED_PROP(float, _RotationX)
#define _RotationX_arr UnlitTextureWorldPos
		UNITY_INSTANCING_BUFFER_END(UnlitTextureWorldPos)


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


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 _Vector2 = float3(0,0,1);
			float _RotationZ_Instance = UNITY_ACCESS_INSTANCED_PROP(_RotationZ_arr, _RotationZ);
			float temp_output_71_0 = radians( _RotationZ_Instance );
			float3 _Vector1 = float3(0,1,0);
			float _RotationY_Instance = UNITY_ACCESS_INSTANCED_PROP(_RotationY_arr, _RotationY);
			float temp_output_67_0 = radians( _RotationY_Instance );
			float3 _Vector0 = float3(1,0,0);
			float _RotationX_Instance = UNITY_ACCESS_INSTANCED_PROP(_RotationX_arr, _RotationX);
			float temp_output_61_0 = radians( _RotationX_Instance );
			float3 ase_worldPos = i.worldPos;
			float3 rotatedValue54 = RotateAroundAxis( float3( 0,0,0 ), ase_worldPos, _Vector0, temp_output_61_0 );
			float3 rotatedValue66 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue54, _Vector1, temp_output_67_0 );
			float3 rotatedValue72 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue66, _Vector2, temp_output_71_0 );
			float3 break51 = rotatedValue72;
			float3 appendResult52 = (float3(break51.x , break51.y , break51.z));
			float2 _UVScale_Instance = UNITY_ACCESS_INSTANCED_PROP(_UVScale_arr, _UVScale);
			float3 break30 = ( appendResult52 / float3( ( -1.0 * abs( _UVScale_Instance ) ) ,  0.0 ) );
			float2 appendResult35 = (float2(break30.x , 0.0));
			float2 appendResult31 = (float2(break30.y , 0.0));
			float3 ase_worldNormal = i.worldNormal;
			float3 rotatedValue75 = RotateAroundAxis( float3( 0,0,0 ), ase_worldNormal, _Vector0, temp_output_61_0 );
			float3 rotatedValue76 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue75, _Vector1, temp_output_67_0 );
			float3 rotatedValue77 = RotateAroundAxis( float3( 0,0,0 ), rotatedValue76, _Vector2, temp_output_71_0 );
			float3 break80 = rotatedValue77;
			float4 lerpResult45 = lerp( tex2D( _Texture0, appendResult35 ) , tex2D( _Texture0, appendResult31 ) , abs( break80.x ));
			float2 appendResult38 = (float2(break30.x , break30.y));
			float4 lerpResult47 = lerp( lerpResult45 , tex2D( _Texture0, appendResult38 ) , abs( break80.z ));
			o.Emission = lerpResult47.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows noshadow 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD1;
				float3 worldNormal : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
1920;0;1920;1019;4846.387;3442.511;2.074646;True;False
Node;AmplifyShaderEditor.CommentaryNode;82;-3964.585,-2926.838;Float;False;1851.896;1019.743;World plane rotator;17;62;65;68;61;53;54;70;69;67;73;71;66;72;74;75;76;77;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-3713.212,-2261.57;Float;False;InstancedProperty;_RotationX;RotationX;2;0;Create;True;0;0;False;0;90;90;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;65;-3563.753,-2414.09;Float;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;68;-3285.856,-2094.887;Float;False;InstancedProperty;_RotationY;RotationY;3;0;Create;True;0;0;False;0;90;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;61;-3537.661,-2254.537;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;53;-3664.407,-2132.095;Float;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RotateAboutAxisNode;54;-3336.737,-2302.91;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-2848.274,-2117.862;Float;False;InstancedProperty;_RotationZ;RotationZ;4;0;Create;True;0;0;False;0;90;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;69;-3094.875,-2456.874;Float;False;Constant;_Vector1;Vector 1;3;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RadiansOpNode;67;-3062.787,-2089.493;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;66;-2881.271,-2305.791;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;23;-1971.424,-2282.29;Float;False;835.1289;489.2509;Pos;5;17;20;21;22;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RadiansOpNode;71;-2625.205,-2112.468;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;73;-2657.293,-2479.849;Float;False;Constant;_Vector2;Vector 2;3;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;74;-3914.585,-2876.838;Float;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;17;-1921.425,-1954.039;Float;False;InstancedProperty;_UVScale;UV Scale;1;0;Create;True;0;0;False;0;1,1;3,3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RotateAboutAxisNode;72;-2443.689,-2328.766;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;75;-3387.118,-2734.003;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;51;-1900.425,-2418.539;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;20;-1720.314,-2014.648;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;21;-1673.481,-1905.826;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1516.446,-2002.25;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;52;-1635.055,-2423.986;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;76;-2917.877,-2746.143;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;19;-1336.376,-2149.516;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;77;-2452.846,-2689.794;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RelayNode;78;-1239.969,-1114.69;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;36;-557.2524,-1939.138;Float;False;548.7903;280;c2;2;35;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;8;-1484.884,-1734.34;Float;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;False;0;c6528a39d3fe6d84e841d0d4fb8e93f4;c6528a39d3fe6d84e841d0d4fb8e93f4;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.BreakToComponentsNode;30;-1096.171,-2144.276;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;32;-558.2656,-2291.724;Float;False;519.4476;280;c1;2;29;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-540.5756,-2236.452;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;42;-396.4587,-1214.097;Float;False;225.1915;274.6836;alpha21;1;41;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;80;-923.8586,-1024.097;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;35;-534.1772,-1889.372;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;39;-566.2245,-1595.729;Float;False;551.9337;280;c3;2;37;38;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RelayNode;34;-1058.154,-1776.747;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;46;257.6778,-1821.058;Float;False;274.551;293.1096;c21;1;45;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;33;-329.462,-1889.138;Float;True;Property;_TextureSample3;Texture Sample 3;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;41;-346.4587,-1164.097;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-329.3033,-2243.519;Float;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;43;-387.756,-887.664;Float;False;218.9586;302.1078;alpha23;1;44;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-534.174,-1544.848;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.AbsOpNode;44;-353.468,-822.9517;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;-318.412,-1532.226;Float;True;Property;_TextureSample4;Texture Sample 4;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;48;629.8294,-1802.661;Float;False;304.5889;281.0945;c23;1;47;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;45;288.1532,-1765.05;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;47;679.8294,-1752.661;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1259.333,-1692.326;Float;False;True;4;Float;ASEMaterialInspector;0;0;Unlit;Unlit Texture World Pos;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;61;0;62;0
WireConnection;54;0;65;0
WireConnection;54;1;61;0
WireConnection;54;3;53;0
WireConnection;67;0;68;0
WireConnection;66;0;69;0
WireConnection;66;1;67;0
WireConnection;66;3;54;0
WireConnection;71;0;70;0
WireConnection;72;0;73;0
WireConnection;72;1;71;0
WireConnection;72;3;66;0
WireConnection;75;0;65;0
WireConnection;75;1;61;0
WireConnection;75;3;74;0
WireConnection;51;0;72;0
WireConnection;21;0;17;0
WireConnection;22;0;20;0
WireConnection;22;1;21;0
WireConnection;52;0;51;0
WireConnection;52;1;51;1
WireConnection;52;2;51;2
WireConnection;76;0;69;0
WireConnection;76;1;67;0
WireConnection;76;3;75;0
WireConnection;19;0;52;0
WireConnection;19;1;22;0
WireConnection;77;0;73;0
WireConnection;77;1;71;0
WireConnection;77;3;76;0
WireConnection;78;0;77;0
WireConnection;30;0;19;0
WireConnection;31;0;30;1
WireConnection;80;0;78;0
WireConnection;35;0;30;0
WireConnection;34;0;8;0
WireConnection;33;0;34;0
WireConnection;33;1;35;0
WireConnection;41;0;80;0
WireConnection;29;0;34;0
WireConnection;29;1;31;0
WireConnection;38;0;30;0
WireConnection;38;1;30;1
WireConnection;44;0;80;2
WireConnection;37;0;34;0
WireConnection;37;1;38;0
WireConnection;45;0;33;0
WireConnection;45;1;29;0
WireConnection;45;2;41;0
WireConnection;47;0;45;0
WireConnection;47;1;37;0
WireConnection;47;2;44;0
WireConnection;0;2;47;0
ASEEND*/
//CHKSM=86D67E9D5014808A2740442C5D574482B01A6A16