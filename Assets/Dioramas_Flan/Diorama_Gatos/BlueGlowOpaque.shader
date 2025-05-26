
Shader "Custom/BlueGlowOpaque"
{
    Properties
    {
        _BaseColor("Base Color", Color) = (0.1, 0.3, 1.0, 1)
        _GlowColor("Glow Color", Color) = (0.6, 0.8, 1.0, 1)
        _GlowStrength("Glow Strength", Float) = 1.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _BaseColor;
            float4 _GlowColor;
            float _GlowStrength;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float glow = pow(1.0 - saturate(dot(viewDir, normalize(i.worldNormal))), 2.5);
                float3 color = _BaseColor.rgb + _GlowColor.rgb * glow * _GlowStrength;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
