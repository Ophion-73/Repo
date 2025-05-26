
Shader "Custom/NeonBlue"
{
    Properties
    {
        _NeonColor("Neon Color", Color) = (0.2, 0.6, 1.0, 1) // Azul neón
        _GlowIntensity("Glow Intensity", Float) = 2.5
        _PulseSpeed("Pulse Speed", Float) = 2.0
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        Blend SrcAlpha One
        ZWrite Off
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _NeonColor;
            float _GlowIntensity;
            float _PulseSpeed;

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

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float2 centerUV = i.uv - 0.5;
                float dist = length(centerUV);
                float glow = exp(-dist * 12.0) * (sin(_Time.y * _PulseSpeed) * 0.5 + 0.5);
                float intensity = glow * _GlowIntensity;

                float3 color = _NeonColor.rgb * intensity;
                return float4(color, intensity);
            }
            ENDCG
        }
    }
}
