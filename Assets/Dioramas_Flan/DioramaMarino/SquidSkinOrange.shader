
Shader "Custom/SquidSkinOrange"
{
    Properties
    {
        _BaseColor("Base Color", Color) = (1.0, 0.5, 0.2, 1)
        _NoiseScale("Noise Scale", Float) = 30.0
        _NoiseIntensity("Noise Intensity", Float) = 0.1
        _SubsurfaceTint("Subsurface Tint", Color) = (1.0, 0.3, 0.1, 1)
        _SubsurfaceStrength("Subsurface Strength", Float) = 0.3
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _BaseColor;
            float _NoiseScale;
            float _NoiseIntensity;
            float4 _SubsurfaceTint;
            float _SubsurfaceStrength;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 worldNormal : TEXCOORD1;
            };

            float hash21(float2 p)
            {
                p = frac(p * float2(123.34, 456.21));
                p += dot(p, p + 34.345);
                return frac(p.x * p.y);
            }

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float noise = hash21(i.uv * _NoiseScale);
                float variation = noise * _NoiseIntensity;

                float subsurface = pow(1.0 - saturate(dot(i.worldNormal, normalize(_WorldSpaceCameraPos))), 2.0);
                float3 subsurfaceLight = _SubsurfaceTint.rgb * subsurface * _SubsurfaceStrength;

                float3 finalColor = _BaseColor.rgb + variation + subsurfaceLight;
                return float4(finalColor, 0.9); // ligeramente traslúcido
            }
            ENDCG
        }
    }
}
