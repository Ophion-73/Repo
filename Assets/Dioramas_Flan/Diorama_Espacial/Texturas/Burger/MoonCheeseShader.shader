
Shader "Custom/MoonCheeseShader"
{
    Properties
    {
        _BaseColor("Base Color", Color) = (1.0, 0.9, 0.5, 1)
        _CraterStrength("Crater Intensity", Float) = 0.1
        _CraterScale("Crater Scale", Float) = 20.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 150

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _BaseColor;
            float _CraterStrength;
            float _CraterScale;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float craterNoise(float2 p)
            {
                return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
            }

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float crater = craterNoise(i.uv * _CraterScale) * _CraterStrength;
                float3 color = _BaseColor.rgb - crater;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
