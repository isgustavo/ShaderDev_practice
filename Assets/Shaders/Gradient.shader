// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Gradient" {

	Properties {

		_Color ("Main color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2d) = "white" {}
	}

	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderyType"="Transparente" }
		Pass {

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			uniform half4 _Color; 
			uniform sampler2D _MainTex;

			struct vertexInput {

				float4 vertex: POSITION;
				float4 texcoord: TEXCOORD0;

			};

			struct vertexOutput {

				float4 pos: SV_POSITION;
				float4 texcoord: TEXCOORD0;
			};


			vertexOutput vert (vertexInput v) {
				
				vertexOutput o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.texcoord.xy = v.texcoord;
				return o;
			}

			half4 frag (vertexOutput i): Color {

				return tex2D(_MainTex, i.texcoord) * _Color;
			}

			ENDCG
		}
	}

}