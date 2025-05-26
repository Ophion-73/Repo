
Shader "Custom/SwampMud"
{
    Properties
    {
        _MudColor("Mud Color", Color) = (0.2, 0.3, 0.15, 1)
        _GrainScale("Grain Scale", Float) = 20.0
        _GrainIntensity("Grain Intensity", Float) = 0.08
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

            float4 _MudColor;
            float _GrainScale;
            float _GrainIntensity;

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

            float hash(float2 p)
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
                float noise = hash(floor(i.uv * _GrainScale));
                float3 color = _MudColor.rgb + noise * _GrainIntensity;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
