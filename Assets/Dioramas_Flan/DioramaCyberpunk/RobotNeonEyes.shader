
Shader "Custom/RobotNeonEyes"
{
    Properties
    {
        _EyeColor("Neon Eye Color", Color) = (1, 0.1, 0.1, 1) // Rojo neón
        _GlowIntensity("Glow Intensity", Float) = 3.0
        _PulseSpeed("Pulse Speed", Float) = 4.0
    }

    SubShader
    {
        Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
        LOD 100
        ZWrite Off
        Blend SrcAlpha One

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _EyeColor;
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
                float glow = exp(-dist * 15.0) * (sin(_Time.y * _PulseSpeed) * 0.5 + 0.5);
                float intensity = glow * _GlowIntensity;

                float3 color = _EyeColor.rgb * intensity;
                return float4(color, intensity);
            }
            ENDCG
        }
    }
}
