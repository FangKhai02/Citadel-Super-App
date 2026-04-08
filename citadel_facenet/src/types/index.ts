// ─── API Types ─────────────────────────────────────────────────────────────────

export interface FaceCompareRequest {
  documentImage: string; // base64
  selfieImage: string;   // base64
}

export interface FaceCompareResponse {
  verified: boolean;
  score: number;
  degraded: boolean;
  message?: string;
}

export interface ApiResponse<T> {
  success: boolean;
  data: T | null;
  error: string | null;
}
