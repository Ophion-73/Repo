
Shader "Custom/WhiteInkStrong"
{
    Properties
    {
        _InkColor("Ink Color", Color) = (1.0, 1.0, 1.0, 0.9)
        _PulseSpeed("Pulse Speed", Float) = 1.5
        _DistortStrength("Distortion Strength", Float) = 0.02
        _Brightness("Brightness", Float) = 1.5
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

            float4 _InkColor;
            float _PulseSpeed;
            float _DistortStrength;
            float _Brightness;

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

            float wave(float2 uv, float t)
            {
                return sin(uv.x * 12.0 + t) + cos(uv.y * 12.0 + t);
            }

            v2f vert(appdata v)
            {
                float t = _Time.y * _PulseSpeed;
                float w = wave(v.uv, t) * _DistortStrength;
                v.vertex.xy += float2(w, w);
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float a = _InkColor.a;
                float3 color = _InkColor.rgb * _Brightness;
                return float4(color, a);
            }
            ENDCG
        }
    }
}
