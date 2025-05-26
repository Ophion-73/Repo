
Shader "Custom/WhiteSkyShader"
{
    Properties
    {
        _SkyColor("Sky Color", Color) = (1, 1, 1, 1)
        _GradientStrength("Gradient Strength", Float) = 1.0
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

            float4 _SkyColor;
            float _GradientStrength;

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
                float gradient = 1.0 - i.uv.y; // más claro arriba
                float brightness = saturate(1.0 - gradient * _GradientStrength * 0.5);
                float3 color = _SkyColor.rgb * brightness;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
