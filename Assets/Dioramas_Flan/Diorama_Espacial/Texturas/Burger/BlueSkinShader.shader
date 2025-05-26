
Shader "Custom/BlueSkinShader"
{
    Properties
    {
        _SkinColor("Skin Color", Color) = (0.3, 0.5, 1.0, 1)
        _SubsurfaceColor("Subsurface Color", Color) = (0.7, 0.9, 1.0, 1)
        _SubsurfacePower("Subsurface Power", Float) = 3.0
        _SubsurfaceStrength("Subsurface Strength", Float) = 0.3
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

            float4 _SkinColor;
            float4 _SubsurfaceColor;
            float _SubsurfacePower;
            float _SubsurfaceStrength;

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
                float fresnel = pow(1.0 - saturate(dot(viewDir, normalize(i.worldNormal))), _SubsurfacePower);
                float3 light = _SubsurfaceColor.rgb * fresnel * _SubsurfaceStrength;
                float3 color = _SkinColor.rgb + light;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
