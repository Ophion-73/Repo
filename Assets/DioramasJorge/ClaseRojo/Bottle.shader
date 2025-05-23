Shader "Jetelly/Bottle"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Fresnel Color", Color) = (1, 1, 1, 1)
        _Power ("Fresnel Power", Range(0, 1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal : COLOR;
                float3 viewDir : COLOR1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;
            float _Power;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = v.normal;
                o.viewDir = normalize(ObjSpaceViewDir(v.vertex));
                return o;
            }

            void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
            {
                Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed fresnel = 0;
                Unity_FresnelEffect_float(i.normal, i.viewDir, _Power, fresnel);
                fixed4 fresnelColor = fresnel * _Color;

                fixed4 col = tex2D(_MainTex, i.uv);
                col += fresnelColor;
                return col;
            }
            ENDCG
        }
    }
}
