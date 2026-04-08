export interface FaceCompareRequest {
    documentImage: string;
    selfieImage: string;
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
//# sourceMappingURL=index.d.ts.map