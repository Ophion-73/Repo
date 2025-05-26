
Shader "Custom/TransparentInteriorShader"
{
    Properties
    {
        _Color("Main Color", Color) = (0.2, 1, 0.8, 0.3) // Verde-azulado con transparencia
        _Alpha("Transparency", Range(0,1)) = 0.3
    }

    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _Color;
            float _Alpha;

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return float4(_Color.rgb, _Alpha);
            }
            ENDCG
        }
    }
}
